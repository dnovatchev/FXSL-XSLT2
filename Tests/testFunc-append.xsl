<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="f"
>
   <xsl:import href="../f/func-append.xsl"/>
   <xsl:output  encoding="UTF-8" omit-xml-declaration="yes" indent="yes"/>
   
   <!-- This transformation must be applied to:
        ../data/numList.xml 

        Expected result: <num>06</num>
	                 <num>07</num>
			 <num>08</num>
			 <num>09</num>
			 <num>10</num>
			 <num>01</num>
			 <num>02</num>
			 <num>03</num>
			 <num>04</num>
			 <num>05</num>
    -->

    <xsl:template match="/">

      <xsl:sequence select="f:append(/*/*[position() > 5], 
                                    /*/*[position() &lt;= 5]
                                    )"
       />
    </xsl:template>
</xsl:stylesheet>
