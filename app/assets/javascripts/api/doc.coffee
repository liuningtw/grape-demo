$ ->
  if $("#swagger-ui-container").length > 0
    swaggerUi = new SwaggerUi
      url: "/api/v1/doc"
      dom_id: "swagger-ui-container"
      supportedSubmitMethods: ['get', 'post', 'put', 'delete']
      onComplete: (swaggerApi, swaggerUi)->
        $('pre code').each (i, e)-> hljs.highlightBlock e
      onFailure: (data)->
      docExpansion: "list"
    swaggerUi.load()
    console.log("v1")

  if $("#kalading-two-b").length > 0
    swaggerUi = new SwaggerUi
      url: "/api/v2/doc"
      dom_id: "kalading-two-b"
      supportedSubmitMethods: ['get', 'post', 'put', 'delete']
      onComplete: (swaggerApi, swaggerUi)->
        $('pre code').each (i, e)-> hljs.highlightBlock e
      onFailure: (data)->
      docExpansion: "list"
    swaggerUi.load()
    console.log("v2")