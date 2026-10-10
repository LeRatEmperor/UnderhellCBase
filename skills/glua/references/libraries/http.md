# http

**Realm:** Shared, Menu  ·  **Members:** 2

The http library allows either the server or client to communicate with external websites via HTTP, both `GET` ([http.Fetch](https://wiki.facepunch.com/gmod/http.Fetch)) and `POST` ([http.Post](https://wiki.facepunch.com/gmod/http.Post)) are supported. A more powerful & advanced method can be used via the global [HTTP](https://wiki.facepunch.com/gmod/Global.HTTP) function.

[wiki page](https://wiki.facepunch.com/gmod/http)

### http.Fetch · Shared, Menu
`http.Fetch(url: string, onSuccess: function = nil, onFailure: function = nil, headers: table = {})`

Launches an asynchronous **GET** request to an HTTP server. Internally calls [HTTP](https://wiki.facepunch.com/gmod/Global.HTTP).

HTTP requests returning a status code >= `400` are still considered a success and will call the [onSuccess](https://wiki.facepunch.com/gmod/Structures/HTTPRequest) callback.

The [onFailure](https://wiki.facepunch.com/gmod/Structures/HTTPRequest) callback is usually only called on DNS or TCP errors (e.g. the website is unavailable or the domain does not exist).

A rough overview of possible [onFailure](https://wiki.facepunch.com/gmod/Structures/HTTPRequest) messages:
* `invalid url` - Invalid/empty url. ( no request was attempted )
* `invalid request` - Steam HTTP lib failed to create a HTTP request.
* `error` - OnComplete callback's second argument, `bError`, is `true`.
* `unsuccessful` - OnComplete's first argument, `pResult->m_bRequestSuccessful`, returned `false`.





**Not all headers are allowed in the client realm, here is a list of known blacklisted headers inside the client realm:**
```
host
expect
content-length
proxy-authenticate
accept-charset
connection
accept-encoding
origin
date
```

**Arguments:**
- `url` (string) — The URL of the website to fetch.
- `onSuccess` (function, default `nil`) — Function to be called on success.
- `onFailure` (function, default `nil`) — Function to be called on failure.
- `headers` (table, default `{}`) — KeyValue table for headers.

> **Note:** HTTP-requests that respond with a large body may return an `unsuccessful` error. Try using the [Range](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Range) header to download the file in chunks.
> **Note:** HTTP-requests to destinations on private networks (such as `192.168.0.1`, or `127.0.0.1`) won't work.
> 	
> 	To enable HTTP-requests to destinations on private networks use [Command Line Parameters](https://wiki.facepunch.com/gmod/Command%20Line%20Parameters) `-allowlocalhttp`. (Dedicated servers only)
> **Bug** ([#2232](https://github.com/Facepunch/garrysmod/issues/2232)): This cannot send or receive multiple headers with the same name.

[wiki](https://wiki.facepunch.com/gmod/http.Fetch) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/http.lua#L18-L44)

---

### http.Post · Shared, Menu
`http.Post(url: string, parameters: table, onSuccess: function = nil, onFailure: function = nil, headers: table = {})`

Sends an asynchronous **POST** request to an HTTP server. Internally calls [HTTP](https://wiki.facepunch.com/gmod/Global.HTTP).

HTTP requests returning a status code >= `400` are still considered a success and will call the [onSuccess](https://wiki.facepunch.com/gmod/Structures/HTTPRequest) callback.

The [onFailure](https://wiki.facepunch.com/gmod/Structures/HTTPRequest) callback is usually only called on DNS or TCP errors (e.g. the website is unavailable or the domain does not exist).

**Arguments:**
- `url` (string) — The url to of the website to post.
- `parameters` (table) — The post parameters (x-www-form-urlencoded) to be send to the server.
- `onSuccess` (function, default `nil`) — Function to be called on success.
- `onFailure` (function, default `nil`) — Function to be called on failure.
- `headers` (table, default `{}`) — KeyValue table for headers.

> **Note:** HTTP-requests that respond with a large body may return an `unsuccessful` error. Try using the [Range](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Range) header to download the file in chunks.
> **Note:** HTTP-requests to destinations on private networks (such as `192.168.0.1`, or `127.0.0.1`) won't work.
> 	
> 	To enable HTTP-requests to destinations on private networks use [Command Line Parameters](https://wiki.facepunch.com/gmod/Command%20Line%20Parameters) `-allowlocalhttp`. (Dedicated servers only)
> **Bug** ([#2232](https://github.com/Facepunch/garrysmod/issues/2232)): This cannot send or receive multiple headers with the same name.

[wiki](https://wiki.facepunch.com/gmod/http.Post) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/http.lua#L46-L73)
