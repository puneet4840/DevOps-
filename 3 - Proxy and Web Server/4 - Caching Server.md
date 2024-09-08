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

