import '@testing-library/jest-dom/vitest';
import { afterEach } from 'vitest';
import { cleanup } from '@testing-library/react';

// Bersihkan DOM setelah tiap tes agar tes tidak saling memengaruhi
afterEach(() => {
  cleanup();
});
