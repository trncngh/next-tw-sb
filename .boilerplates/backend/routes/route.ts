const {{fileName}}Router = Router()

{{fileName}}Router.get('/', get{{fileName}})
{{fileName}}Router.get('/id', get{{fileName}}ById)
{{fileName}}Router.post('/', createNew{{fileName}})
{{fileName}}Router.patch('/:id', update{{fileName}}ById)
{{fileName}}Router.delete('/:id', delete{{fileName}}ById)
{{fileName}}Router.delete('/', deleteAll{{fileName}})


export default {{fileName}}Router