@isTest
public with sharing class GoogleDriveAPIClientTest {
    @isTest
    static void testCopyFile() {
        Test.setMock(HttpCalloutMock.class, new HttpResponseMock(200, JSON.serialize(new Map<String, String>{
            'kind' => 'some kind',
            'id' => 'some id',
            'name' => 'some name',
            'mimeType' => 'some mimeType'
        })));
        GoogleDriveAPIClient client = new GoogleDriveAPIClient();
        client.copyFile('src', 'name', 'parent');
    }

    @isTest
    static void testCreateFolder() {
        Test.setMock(HttpCalloutMock.class, new HttpResponseMock(200, JSON.serialize(new Map<String, String>{
            'kind' => 'some kind',
            'id' => 'some id',
            'name' => 'some name',
            'mimeType' => 'some mimeType'
        })));
        GoogleDriveAPIClient client = new GoogleDriveAPIClient();
        client.createFolder('name', 'parent');
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
