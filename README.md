# possemar-frontend

Frontend PosSemar: web analisis ulasan kantor pos se-Kota Semarang, berisi sisi user dan Dashboard Admin dalam satu aplikasi React.

## Status

Kerangka awal. Kode menyusul.

## Catatan

- Repo ini publik. Jangan menaruh rahasia, token, atau data ulasan asli di sini.
- Environment variable ada di `.env.example` (hanya nama, nilai kosong).
- Kerja di cabang `fitur/<nama>`, gabung ke `main` lewat pull request.

## Menjalankan

Syarat: Node.js 22.13 atau lebih baru (disarankan 24 LTS atau 26 LTS).

| Perintah                                  | Fungsi                                                            |
| ----------------------------------------- | ----------------------------------------------------------------- |
| `npm install`                             | Pasang dependensi                                                 |
| `npm run dev`                             | Server pengembangan di `http://localhost:5173/possemar-frontend/` |
| `npm run lint`                            | Pemeriksaan ESLint                                                |
| `npm run format` / `npm run format:check` | Merapikan / memeriksa format Prettier                             |
| `npm test`                                | Tes sekali jalan (Vitest)                                         |
| `npm run build`                           | Build produksi ke `dist/`                                         |
