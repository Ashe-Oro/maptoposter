# Production Deployment TODO

## Phase 1: Hosting Setup (Do First)
These block everything else - you need somewhere to deploy before anything works.

- [ ] **Choose hosting provider**
  - Recommended: Railway or Render (both have persistent storage + easy setup)
  - Needs: Python + Node.js support, persistent disk storage
  - Skip Heroku unless you want to add S3 for file storage
- [ ] **Configure Python environment for poster generator**
  - cairo, osmium, geographic libraries required
  - Test that poster generation works on the platform
- [ ] **Set up persistent storage for generated posters and gallery.json**
  - Railway/Render: Use their persistent volumes
  - Heroku: Requires S3 or similar

## Phase 2: Domain & Security
Once hosting works, make it accessible via your domain.

- [ ] **Purchase cartograph.art domain**
  - Namecheap, Cloudflare, or Google Domains
- [ ] **Point domain to hosting provider**
  - Add DNS records (usually A record or CNAME)
  - Most hosts have guides for this
- [ ] **Configure SSL certificate for HTTPS**
  - Usually automatic with Railway/Render/Heroku
  - Just enable it in dashboard after domain is connected

## Phase 3: Environment & Configuration
Configure the app for production use.

- [ ] **Set up production environment variables**
  - USDC receiving address (your wallet for payments)
  - Reown project ID (get from reown.com dashboard)
  - Facilitator URL (x402 facilitator endpoint)
- [ ] **Update CORS and allowed origins for production domain**
  - Add cartograph.art to allowed origins in server config
  - Currently `cors()` allows ALL origins - must restrict!

## Phase 3.5: Security Hardening (Before Launch)

- [ ] **Rotate compromised credentials**
  - CDP API keys may be exposed in git history
  - Regenerate all keys in Coinbase Developer Platform
- [ ] **Disable debug logging**
  - Set `DEBUG_X402 = false` in `/server/src/middleware/x402.js`
  - Or make it configurable via env var
- [ ] **Add rate limiting**
  - Install `express-rate-limit`
  - Apply to non-payment endpoints (gallery, themes, jobs)
  - Payment endpoint already has natural rate limiting via cost
- [ ] **Restrict CORS to production domain**
  - Change `cors()` to `cors({ origin: ['https://cartograph.art'] })`

## Phase 4: Test & Launch
Verify everything works before announcing.

- [ ] **Test full user flow on production**
  - Generate a poster
  - Complete x402 payment
  - Verify poster download works
- [ ] **Set up basic monitoring/logging** (optional but recommended)
  - Most hosts have built-in logging dashboards
  - Consider: Sentry for error tracking (free tier available)
- [ ] **Soft launch** - share with a few people first to catch issues

---

## Quick Start Recommendation

If you want the fastest path to production:

1. **Railway** - Sign up, connect GitHub repo, deploy
2. Add a **volume** for `/app/server/data` (or wherever posters are stored)
3. Buy domain from **Cloudflare** (includes free SSL/CDN)
4. Point domain to Railway, set env vars, done

Total time: A few hours. Cost: ~$5-20/month depending on usage.
