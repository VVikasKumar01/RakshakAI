import { resolve } from 'path';
import { defineConfig } from 'vite';

export default defineConfig({
  build: {
    rollupOptions: {
      input: {
        main: resolve(__dirname, 'index.html'),
        home: resolve(__dirname, 'home.html'),
        dashboard: resolve(__dirname, 'dashboard.html'),
        regulations: resolve(__dirname, 'regulations.html'),
        kanban: resolve(__dirname, 'kanban.html'),
        audit_log: resolve(__dirname, 'audit_log.html'),
      },
    },
  },
});
