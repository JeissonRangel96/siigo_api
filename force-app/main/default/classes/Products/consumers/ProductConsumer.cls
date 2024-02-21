public with sharing class ProductConsumer {
    
    public ProductConsumer() {
    }

    @InvocableMethod(label='Metodo para actualizar inventario'
                     description='Hace lo que dice el nombre'
                     category='Product2')
    public static void registrarProductos(){

        RequestBuilder request = new RequestBuilder(ProductConstants.ENDPOINT);

        request.setMethod('GET');

        HttpResponse response = request.makeRequest('');

        if(response.getStatusCode() == 200) {
            // Deserialize the JSON string into collections of primitive data types.
            Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            List<Object> products = (List<Object>) results.get('results');
            System.debug('Received the following products:');
            for(Object product: products) {
                System.debug(products);
                Map<String, Object> sProduct = (Map<String, Object>) product;
                Product2 newProduct = new Product2();
                newProduct.ProductCode = (String) sProduct.get('code');
                newProduct.Name = (String) sProduct.get('name');
                //System.debug('Funciono ? '+ ((Map<String, Object>) sProduct.get('account_group')).get('id'));
                newProduct.Account_Group__c	= (Decimal)((Map<String, Object>) sProduct.get('account_group')).get('id');
                newProduct.Type__c = (String) sProduct.get('type');
                newProduct.IsActive = (Boolean) sProduct.get('active');
                newProduct.Description = (String) sProduct.get('description');
                insert newProduct;
            }
        }
    }
}