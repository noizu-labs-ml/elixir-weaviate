# Threat Model Summary

Client library — no inbound surface. One trust boundary: host process → Weaviate endpoint (HTTP egress, bearer `weaviate_api_key` from app env). Assets: API credential, vector data in transit. Deployment perimeter owned by the consumer.

Register: T-001 High (default endpoint plain HTTP — consumer must set HTTPS) · T-002 Medium DoS (`Jason.decode keys: :atoms` on responses; accepted, trusted-endpoint assumption) · T-003 Low info disclosure (error logs inspect bodies; accepted) · T-004 Low DoS (600 s fixed Finch timeouts; accepted) · T-005 dev-only anonymous docker-compose (scoped out).

Coverage: none mitigated in code; rests on consumer setting HTTPS endpoint. Full detail: [THREAT-MODEL.md](THREAT-MODEL.md).
