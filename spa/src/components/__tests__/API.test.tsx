import React from 'react'
import { render, screen } from '@testing-library/react'

import {  listCategories } from '../../services/API'

describe('List Categories', () => {
  beforeEach(() => {
    // Create Mock Data Here
    // fetchMock.resetMocks()
  })

  test('return all the categories when API success ', async () => {})

  test('returns error when API call fails', async () => {})
})



describe('Create Video', () => {
    beforeEach(() => {
      // Create Mock Data Here
      // fetchMock.resetMocks()
    })
  
    test('return success on creating video', async () => {})
  
    test('returns error when API call fails', async () => {})
  })