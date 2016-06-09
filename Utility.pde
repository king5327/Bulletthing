static class Utility{
    public static String[] arraySub(String[] array, int start, int end){
        String[] newarray = new String[end - start];
        for(int i = start; i < end; i++){
            newarray[i - start] = array[i];
            //println(array[i]);
        }
        return newarray;
    }
    
    public static void toMap(HashMap<Object, Object> m, String... s){ //Should take strings, assign the even indices as keys and the odds as values to the given map.
        for(int position = 0; position < s.length - 1;){
            m.put(s[position++], s[position++]);
        }
    }
}