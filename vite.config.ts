import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";
import path from "path";
import { fileURLToPath } from "url"; // Import required for __dirname fix

// Fix for __dirname in ES modules
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

// https://vite.dev/config/
export default defineConfig(({ mode }) => ({
  plugins: [
    react()
    // Chef plugin code is removed here to clean up the config.
  ].filter(Boolean),
  
  resolve: {
    alias: {
      "@": path.resolve(__dirname, "./src"),
    },
  },

  // Required Server Configuration to fix 'Connection Refused' and 'Blocked Host'
  server: {
    host: true, // Listen on all network interfaces (0.0.0.0)
    port: 3000, 
    allowedHosts: [
      "todoapp.uksouth.cloudapp.azure.com"
    ]
  }
}));
