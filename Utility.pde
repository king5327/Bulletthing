static class Utility{
    public static String[] arraySub(String[] array, int start, int end){
        String[] newarray = new String[end - start];
        for(int i = start; i < end; i++){
            newarray[i - start] = array[i];
            println(array[i]);
        }
        return newarray;
    }
    
    
}