<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="f xs"
>
  <xsl:import href="func-apply.xsl"/>
  
  <xsl:function name="f:str-dropWhile">
    <xsl:param name="pStr" as="xs:string"/>
    <xsl:param name="pPredicate" as="element()"/>

    <xsl:sequence select=
     "if(not($pStr))
        then ()
        else
          for $vDrop in f:apply($pPredicate, 
                                substring($pStr, 1, 1) 
                                ) 
             return
	            if($vDrop)
	              then
	                f:str-dropWhile(substring($pStr, 2), 
	                                $pPredicate 
	                                ) 
	              else
	                $pStr"
     />
  </xsl:function>
</xsl:stylesheet>