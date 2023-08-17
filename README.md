# jaredhowland/caddy-cloudflare
Docker container for a Caddy 2 server with Cloudflare DNS module pre-installed.

# Usage
```bash
docker pull ghcr.io/jaredhowland/caddy-cf:latest
```

[List of all available image tags](https://github.com/users/jaredhowland/packages?repo_name=caddy-cloudflare)

# Example `Caddyfile`
This example assumes you have PHP-FPM running in a separate container named `php`. Adjust as needed if this is not what you need. See [Caddyfile documentation](https://caddyserver.com/docs/caddyfile) for more information.

It also assumes you serve all your sites from `/var/www/html` and each domain has its own directory with a `public_html` directory inside for serving your site. For example, if your domain is `domain.com` it assumes you are serving that site via `/var/www/html/domain.com/public_html`. Again, change this to meet your needs.

```yaml
# The Caddyfile is an easy way to configure your Caddy web server.
#
# Unless the file starts with a global options block, the first
# uncommented line is always the address of your site.
#
# To use your own domain name (with automatic HTTPS), first make
# sure your domain's A/AAAA DNS records are properly pointed to
# this machine's public IP, then replace ":80" below with your
# domain name.

(website) {
    # Setup Cloudflare so certificates can be auto-issued and renewed
    tls email@example.com {
      dns cloudflare {env.CF_API_TOKEN}
    }
    
    root * /var/www/html/{args[0]}/public_html

    # Compress files
    encode zstd gzip

    # Serve a PHP site through PHP-FPM (assumes your PHP container is named `php`)
    php_fastcgi php:9000 {
      try_files {path} {path}/index.php =404
    }

    # Use a Caddy template to handle all errors (place an `error.html` file in your root)
    handle_errors {
      rewrite * /error.html
      templates
      file_server
    }

    # Enable the static file server.
    file_server
}

DOMAIN1.TLD {
    import website "DOMAIN1.TLD"
}

DOMAIN2.TLD {
    import website "DOMAIN2.TLD"
}

# Refer to the Caddy docs for more information:
# https://caddyserver.com/docs/caddyfile

```

# Example `error.html` File
Place this in the root directory of the site(s) you are serving through Caddy to automatically generate an error page (404 etc.).

```html
<!doctype html>
<html lang=en>
<meta charset=utf-8>
<title>{{placeholder "http.error.status_code"}} Error</title>

<h1>{{placeholder "http.error.status_code"}} Error</h1>

<p>{{placeholder "http.error.status_text"}}</p>

</html>
``` 
