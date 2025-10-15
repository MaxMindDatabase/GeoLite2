# @MaxMindDatabase/GeoLite2

## Installation

```bash
npm install @MaxMindDatabase/GeoLite2
```

## Examples

### GeoLite2 Class

```typescript
import { GeoLite2 } from "@maxminddatabase/geolite2";
import type { ReaderModel, City } from "@maxminddatabase/geolite2/types";

const reader: ReaderModel = new GeoLite2("City").reader;

const city: City = reader.city("8.8.8.8");
```
