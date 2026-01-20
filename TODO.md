# TODO List - City Map Poster Generator

## Local Caching for Map Data

**Priority:** High
**Impact:** Dramatically faster poster generation for repeat/popular locations

### Options
- SQLite database
- Pickle files (keyed by city_country_distance)

### Implementation
1. Before fetching from Overpass API, check local cache first
2. Cache key: `{city}_{country}_{distance}` (normalized/slugified)
3. Store: street graph (pickled NetworkX), water features (pickled GeoDataFrame)
4. Each new fetch should be saved to cache after retrieval
5. Add cache expiry (e.g., 30 days) to get updated OSM data periodically
6. Pre-populate cache with popular cities for instant generation

### Benefits
- Instant generation for repeat/popular locations
- Reduces load on Overpass API
- Works offline for cached cities

---

## Retheme Optimization

**Priority:** High
**Impact:** Retheme goes from 2-3 minutes to a few seconds

### Problem
- Currently retheme re-fetches all data from Overpass API (slow!)
- Theme is just colors - should be instant

### Solution
- With caching implemented, retheme would hit cache and skip API calls
- Only re-render with new theme colors
- Alternative: save `{job_id}_data.pkl` alongside poster for job-specific caching

### Expected Improvement
- Current: 2-3 minutes per retheme
- After: Few seconds (render only)

---

## Future Ideas

- [ ] Pre-generate popular cities on server startup
- [ ] Add more Overpass API endpoints for better load balancing
- [ ] WebSocket for real-time progress updates instead of polling
- [ ] Queue system for handling multiple concurrent requests
- [ ] Thumbnail previews before full generation
