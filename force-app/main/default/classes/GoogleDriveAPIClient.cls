public with sharing class GoogleDriveAPIClient {
    public GoogleDriveCreateResponse createFolder(String name, String parentID) {
        Map<String, Object> params = new Map<String, Object>{
            'name' => name,
            'mimeType' => 'application/vnd.google-apps.folder'
        };
        if (String.isNotBlank(parentID)) {
            params.put('parents', new List<String>{
                parentID
            });
        }
        String body = this.post(
            'callout:GoogleDriveAPI/drive/v3/files',
            JSON.serialize(params),
            null
        );
        return (GoogleDriveCreateResponse)JSON.deserializeStrict(body, GoogleDriveCreateResponse.class);
    }

    public GoogleDriveCreateResponse copyFile(String srcID, String name, String parentID) {
        Map<String, Object> params = new Map<String, Object>{
            'name' => name
        };
        if (String.isNotBlank(parentID)) {
            params.put('parents', new List<String>{
                parentID
            });
        }
        String body = this.post(
            'callout:GoogleDriveAPI/drive/v3/files/' + srcID + '/copy',
            JSON.serialize(params),
            null
        );
        // System.debug(body);
        return (GoogleDriveCreateResponse)JSON.deserializeStrict(body, GoogleDriveCreateResponse.class);
    }

    private String post(String uri, String body, Map<String, String> headers) {
        return this.request('POST', uri, body, headers);
    }

    private String get(String uri, Map<String, String> headers) {
        return this.request('GET', uri, '', headers);
    }

    private String request(String method, String uri, String body, Map<String, String> headers) {
        HttpRequest req = new HttpRequest();
        req.setEndpoint(uri);
        req.setMethod(method);
        req.setHeader('Content-Type', 'application/json');
        if (headers != null) {
            for (String key : headers.keySet()) {
                req.setHeader(key, headers.get(key));
            }
        }
        if (String.isNotBlank(body)) {
            req.setBody(body);
        }

        Http http = new Http();
        HTTPResponse res = http.send(req);
        Integer statusCode = res.getStatusCode();
        String resBody = res.getBody();
        if (statusCode != 200) {
            System.debug(statusCode);
            System.debug(resBody);
            if (statusCode > 400) {
                throw GoogleAPIException.createFromResponse(resBody);
            }
        }
        return resBody;
    }
}
