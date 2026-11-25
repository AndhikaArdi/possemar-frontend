import { describe, expect, it } from 'vitest';
import { render, screen } from '@testing-library/react';
// Impor lewat alias: tes ini sekaligus membuktikan alias berlaku di Vitest
import StatusKerangka from '@components/StatusKerangka';

describe('StatusKerangka (SEMENTARA)', () => {
  it('menampilkan judul PosSemar', () => {
    render(<StatusKerangka />);
    expect(screen.getByRole('heading', { name: 'PosSemar' })).toBeInTheDocument();
  });
});
