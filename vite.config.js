import { fileURLToPath, URL } from 'node:url';
import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';
import tailwindcss from '@tailwindcss/vite';

// Ubah jalur relatif menjadi jalur absolut dari folder proyek
const folder = (jalur) => fileURLToPath(new URL(jalur, import.meta.url));

export default defineConfig({
  // GitHub Pages menyajikan repo ini di /possemar-frontend/
  base: '/possemar-frontend/',
  plugins: [react(), tailwindcss()],
  resolve: {
    alias: {
      '@routes': folder('./src/routes'),
      '@pages': folder('./src/pages'),
      '@components': folder('./src/pages/components'),
      '@layouts': folder('./src/pages/layouts'),
      '@user': folder('./src/pages/user'),
      '@admin': folder('./src/pages/admin'),
      '@utils': folder('./src/utils'),
      '@apis': folder('./src/utils/apis'),
      '@hooks': folder('./src/utils/hooks'),
      '@stores': folder('./src/utils/stores'),
      '@helpers': folder('./src/utils/helpers'),
      '@data': folder('./src/data'),
      '@': folder('./src'),
    },
  },
  test: {
    environment: 'jsdom',
    setupFiles: ['./tests/setup.js'],
    include: ['tests/**/*.test.{js,jsx}'],
  },
});
