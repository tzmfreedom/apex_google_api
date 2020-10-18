public with sharing class SpreadSheetAPIClient {
    public class CreateDriveResponse {
        public String kind;
        public String id;
        public String name;
        public String mimeType;
    }

    public void updateValues(String spreadsheetID, List<SpreadSheetUpdateValue> data) {
        Map<String, Object> params = new Map<String, Object>{
            'valueInputOption' => 'USER_ENTERED',
            'data' => data,
            'includeValuesInResponse' => true,
            'responseValueRenderOption' => 'UNFORMATTED_VALUE',
            'responseDateTimeRenderOption' => 'FORMATTED_STRING'
        };
        String body = this.post(
            'callout:SpreadSheetAPI/v4/spreadsheets/' + spreadsheetID + '/values:batchUpdate',
            JSON.serialize(params),
            null
        );
        System.debug(body);
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
