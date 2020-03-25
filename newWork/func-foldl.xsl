<xsl:stylesheet version="2.0" 
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="f"
>
    <xsl:import href="../f/func-apply.xsl"/>
    <xsl:import href="../f/func-curry.xsl"/>
    
    <xsl:function name="f:foldl">
      <xsl:param name="pFunc" as="element()"/>
      <xsl:param name="pA0" as="item()*"/>
      <xsl:param name="pList" as="item()*"/>
      
      <xsl:message>
	      f:foldl:
	        $pFunc: <xsl:sequence select="name($pFunc)"/> 
	        $pA0:   <xsl:sequence select="$pA0"/>
	        $pList: <xsl:sequence select="$pList"/>
      </xsl:message>         
      <xsl:sequence select=
             "if (empty($pList))
                  then 
                      $pA0
                  else
                      f:foldl($pFunc, 
                              f:apply($pFunc, $pA0, $pList[1]), 
                              $pList[position() > 1]
                              )"/>
    </xsl:function>

    <xsl:function name="f:foldl" as="element()">
      <f:foldl/>
    </xsl:function>
    
    <xsl:function name="f:foldl">
      <xsl:param name="pFunc" as="element()"/>
      <xsl:param name="pA0" as="item()*"/>
      
      <xsl:sequence select="f:curry(f:foldl(),3,$pFunc,$pA0)"/>
    </xsl:function>
    
    <xsl:template match="f:foldl" mode="f:FXSL">
      <xsl:param name="arg1" as="element()"/>
      <xsl:param name="arg2" as="item()*"/>
      <xsl:param name="arg3" as="item()*"/>
      
      <xsl:sequence select="f:foldl($arg1,$arg2,$arg3)"/>
    
    </xsl:template>
</xsl:stylesheet>