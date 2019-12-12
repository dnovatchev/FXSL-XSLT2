<xsl:stylesheet version="2.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:xs="http://www.w3.org/2001/XMLSchema"
xmlns:f="http://fxsl.sf.net/"
xmlns:str-reverse-func="f:str-reverse-func"
exclude-result-prefixes="f xs str-reverse-func"
>

   <xsl:import href="func-dvc-str-foldl.xsl"/>

    <xsl:function name="f:reverse">
      <xsl:param name="pSeq" as="item()*"/>
      
      <xsl:sequence select=
              "for $i in 1 to count($pSeq) return
                  $pSeq[count($pSeq) - $i + 1]"
      />
    </xsl:function>
</xsl:stylesheet>