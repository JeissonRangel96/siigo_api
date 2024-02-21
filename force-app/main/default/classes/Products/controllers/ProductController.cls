@RestResource(urlMapping='/products/*')
global with sharing class ProductController {
    
    @HttpGet
    global static List<Product2> getAllProducts(){
        try {
            List<Product2> results = new List<Product2>();
            results = [SELECT Id, Name FROM Product2];
            return results;
        } catch (QueryException e) {
            RestResponse res = RestContext.response;
            res.statusCode = 404; // Not Found
            return null;
        }
    }
}