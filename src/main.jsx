import { StrictMode } from 'react';
import { createRoot } from 'react-dom/client';
import '@/styles/index.css';
// SEMENTARA: diganti Providers + RouterProvider di Langkah 3.2
import StatusKerangka from '@components/StatusKerangka';

createRoot(document.getElementById('root')).render(
  <StrictMode>
    <StatusKerangka />
  </StrictMode>,
);
