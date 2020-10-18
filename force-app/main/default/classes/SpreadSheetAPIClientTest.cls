@isTest
public with sharing class SpreadSheetAPIClientTest {
    @isTest
    static void testUpdateValues() {
        Test.setMock(HttpCalloutMock.class, new HttpResponseMock(200, ''));
        SpreadSheetAPIClient client = new SpreadSheetAPIClient();
        List<SpreadSheetUpdateValue> values = new List<SpreadSheetUpdateValue>();
        values.add(new SpreadSheetUpdateValue('シート1!A1:D5', new List<List<Object>>{
            new List<Object>{
                1,
                2,
                3,
                4
            },
            new List<Object>{
                11,
                22,
                33,
                44
            }
        }));
        client.updateValues('xxx', values);
    }

    public class HttpResponseMock implements HttpCalloutMock {
        public String contentType;
        public String body;
        public Integer statusCode;

        public HttpResponseMock(Integer statusCode, String body) {
            this.statusCode = statusCode;
            this.contentType = 'application/json';
            this.body = body;
        }

        // Implement this interface method
        public HTTPResponse respond(HTTPRequest req) {
            // Create a fake response
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', this.contentType);
            res.setBody(this.body);
            res.setStatusCode(this.statusCode);
            return res;
        }
    }
}
