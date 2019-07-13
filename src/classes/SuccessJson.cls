public class SuccessJson {
        public String id;
        public Boolean success;
        public string objectType;
        public List<string> errors;
        public List<string> warnings;
   
    
    public static SuccessJson parse(String json) {
        return (SuccessJson) System.JSON.deserialize(json, SuccessJson.class);
    }
    
}