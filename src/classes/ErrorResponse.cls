public class ErrorResponse {
        public String message;
        public String errorCode;
        public List<String> fields;
        
        public static List<ErrorResponse> parse(String json) {
        return (List<ErrorResponse>) System.JSON.deserialize(json, List<ErrorResponse>.class);
    }
}