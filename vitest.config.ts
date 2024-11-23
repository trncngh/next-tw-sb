/// <reference types="vitest" />
import react from '@vitejs/plugin-react'
import path from 'path'
import { coverageConfigDefaults, defineConfig } from 'vitest/config'

export default defineConfig({
  plugins: [react()],
  test: {
    globals: true,
    environment: 'jsdom',
    coverage: {
      reporter: ['text', 'lcov', 'html', 'json'],
      include: [
        'src/**/*.{test,spec}.{ts,tsx}', // Specify your test files here
      ],
      exclude: [
        '**/*.config.**',
        '**/*.{stories,validate}.{ts,tsx}',
        '**/app/**/*',
        '.boilerplates/**',
        '**/__mock__/**/*',
        ...coverageConfigDefaults.exclude,
      ],
    },
    include: ['src/**/*.{test,spec}.{ts,tsx}'],
  },
  resolve: {
    alias: {
      '@': path.resolve(__dirname, './src'),
    },
  },
})
