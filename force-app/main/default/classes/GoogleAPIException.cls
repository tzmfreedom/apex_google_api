public with sharing class GoogleAPIException extends Exception {
    public Integer statusCode;
    public String status;

    public GoogleAPIException(String message, Integer statusCode, String status) {
        this(message);
        this.statusCode = statusCode;
        this.status = status;
    }

    public static GoogleAPIException createFromResponse(String body) {
        BodyJsonMessage data = (BodyJsonMessage)JSON.deserializeStrict(body, BodyJsonMessage.class);
        return data.toException();
    }

    public class BodyJsonMessage {
        public Error error;

        public GoogleAPIException toException() {
            return new GoogleAPIException(this.error.message, this.error.code, this.error.status);
        }
    }

    public class Error {
        public Integer code;
        public String message;
        public String status;
    }
}
