# Caching Server

### What is Cache?

A Cache is the temporary storage where frequently accessed data is stored for faster access.

The primary purpose of cache is to reduce the time it takes to access the data and improve the efficiency of system.

<br>

e.g., **Example of Google News**

- **Without Cache**

```Imagine you're trying to access a popular website like Google News. Every time you refresh the page, the website has to fetch all the latest news articles from its database and generate the webpage. This can take time, especially during peak hours.```

- **With Cache**

```Now imagine that Google News uses caching. When you visit the website for the first time, it fetches all the latest news articles and stores them in a temporary memory location (cache). The next time you refresh the page, the website can load the cached articles much faster, without having to fetch them from the database again.```

<br>

**How Cache Works?**

- **Storing Data**: When data is requested for the first time, it’s retrieved from the original source (such as a database, file, or web server) and stored in the cache.

- **Serving Cached Data**: On subsequent requests for the same data, the cache returns the stored data instead of fetching it again from the original source. This process is much faster and reduces the load on the system.

- **Refreshing/Invalidating Cache**: Cached data often has a "Time to Live" (TTL) or expiration. Once the TTL expires, the cache is refreshed by fetching updated data from the source.

<br>

### Types of Cache

- **Memory Cache**: Memory Cache is the type of cache which stores in the RAM of server or application. This data storage layer sits between application and database to deliver response with high speed.

  e.g. **Redis**: A popular in-memory key-value store used to cache data in applications.

- **Browser Cache**: Web browsers stores static resources like images, CSS and java script locally. So they don't have to be downloaded everytime a user visits a website.

  e.g., When you visit a website, your browser stores images and scripts in the local cache. On the next visit, instead of downloading these files again, the browser serves them from the cache, speeding up the page load time.


- **Content Delivery Network (CDN) cache**: If you access a webpage hosted on a CDN, the first request may be served from the origin server. Subsequent requests from other users in nearby regions will be served from the nearest CDN node, reducing latency.


<br>

### What is caching server?

A caching server is a server that stores copies of data (web pages, files and other content) temporarily to serve it more quickly to the user. Instead of fetching data from original source it delivers data from its cache.

**How a caching server works?**

When a user requests data (like a webpage or file), the origin server provides it. The caching server then stores a copy of this data locally. For future requests, the caching server checks if the stored data is still valid. If valid, it serves the cached version, avoiding a trip to the origin server. Cached data has an expiration time (TTL), and once it expires, the cache is refreshed by fetching updated data from the origin server.
