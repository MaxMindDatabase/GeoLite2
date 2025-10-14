import { readFileSync } from "fs";
import { dirname, resolve } from "path";
import { fileURLToPath } from "url";

import { Reader, ReaderModel } from "@maxmind/geoip2-node";

export class GeoLite2 {
  private _reader: ReaderModel | null;
  private database: string;

  constructor(database: "ASN" | "City" | "Country") {
    this.database = database;
    this._reader = null;
  }

  get reader(): ReaderModel {
    if (!this._reader) {
      const __dirname = dirname(fileURLToPath(import.meta.url));
      const dbPath = resolve(
        __dirname,
        `../database/GeoLite2-${this.database}.mmdb`,
      );
      const dbBuffer = readFileSync(dbPath);
      this._reader = Reader.openBuffer(dbBuffer);
    }
    return this._reader;
  }
}
