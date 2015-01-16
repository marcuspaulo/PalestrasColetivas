
class DataUtil {
    
    let RANGE_DIA_INICIO :Int = -8;
    let RANGE_DIA_FIM :Int = -6;
    
    let RANGE_MES_INICIO :Int = -5;
    let RANGE_MES_FIM  :Int = -3;
    
    let RANGE_ANO_INICIO :Int = -10;
    let RANGE_ANO_FIM :Int = -6;
    
    
    /*
    * Método que extrai a data, através da SubString e do Range de acordo com o 
    * tipo de Data - Dia, Mês ou Ano.
    * Formato passado: 2015-01-15
    */
    func extrairData(data:String, tipoInicio:Int, tipoFim:Int) -> String {
        
        var dataExtraida : String;
        
        let range = Range(start: (advance(data.endIndex, tipoInicio)), end: (advance(data.endIndex, tipoFim)))
        dataExtraida = data.substringWithRange(range);
        
        return dataExtraida;
    }
    
    
    /*
     * Método responsável por indicar as posições do Range de SubString - ANO
     */
    func extrairAno(data:String) -> String {
        var ano :String  = "";
        ano = extrairData(data, tipoInicio: RANGE_ANO_INICIO, tipoFim: RANGE_ANO_FIM);
        return ano;
    }
    
    /*
    * Método responsável por indicar as posições do Range de SubString - MÊS
    */
    func extrairMes(data:String) -> String {
        return extrairData(data, tipoInicio: RANGE_MES_INICIO, tipoFim: RANGE_MES_FIM);
    }
    
    /*
    * Método responsável por indicar as posições do Range de SubString - Dia
    */
    func extrairDia(data:String) -> String {
        return extrairData(data, tipoInicio: RANGE_DIA_INICIO, tipoFim: RANGE_DIA_FIM);
    }

}