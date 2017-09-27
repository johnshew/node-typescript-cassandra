// map.ts
import { Client } from "cassandra-driver";
declare module "cassandra-driver" {
    namespace metadata {
        interface Metadata {
            keyspaces: { [key: string]: any }
        }
    }

    interface Client {
        connect(): Promise<void>;
    }
}
