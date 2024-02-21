public with sharing class RequestBuilder {

    private String apiUrl;
    private String method;
    private Map<String, String> headers;

    public RequestBuilder(String apiUrl) {
        this.apiUrl = apiUrl;
        this.headers = new Map<String, String>();
    }
    public void addHeader(String key, String value) {
        this.headers.put(key, value);
    }
    
    public void setMethod(String method) {
        this.method = method;
    }

    public HttpResponse makeRequest(String requestBody) {
        HttpRequest request = new HttpRequest();
        request.setEndpoint(apiUrl);
        request.setMethod(method);

        for (String key : headers.keySet()) {
            request.setHeader(key, headers.get(key));
        }

        if (method == 'POST' || method == 'PUT') {
            request.setHeader('Content-Type', 'application/json');
            request.setBody(requestBody);
        }

        Http http = new Http();
        return http.send(request);
    }

}