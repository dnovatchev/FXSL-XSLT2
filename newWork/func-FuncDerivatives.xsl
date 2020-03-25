<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="xs f"
>

 <xsl:import href="../f/func-curry.xsl"/>
 <xsl:import href="../f/func-apply.xsl"/>
 <xsl:import href="../f/func-Operators.xsl"/>

 
<!--
       This module contains the FXSL versions of the derivatives of the       
       "builtin" XPath numerical operators and of functions taking and        
       returning one real <- R argument
                                                                              
-->

 <xsl:function name="f:const" as="xs:anyAtomicType">
   <xsl:param name="pNum" as="xs:anyAtomicType"/>
   <xsl:param name="pIgnored"/>
   
   <xsl:sequence select="$pNum"/>
 </xsl:function>

 <xsl:function name="f:const" as="element()">
   <f:const/>
 </xsl:function>
 
 <xsl:template match="f:const" mode="f:FXSL">
   <xsl:param name="arg1" as="xs:anyAtomicType"/>
   <xsl:param name="arg2"/>
   
   <xsl:sequence select="f:const($arg1, $arg2)"/>
 </xsl:template>


 <xsl:function name="f:Prime"  as="element()">
   <xsl:param name="pFun" as="element()"/>
   
   <xsl:variable name="vPrimeFun" select=
    "document('')/*/*
       [name() = concat(name($pFun), '_Prime')]"/>
   <xsl:variable name="vdiffResult" select=
        "if(exists($vPrimeFun))
           then f:apply($vPrimeFun)
           else f:const(0)"/>
 </xsl:function>

  <f:add_Prime/>
  <xsl:template match="f:add_Prime" mode="f:FXSL">
   <xsl:param name="arg1"/>
   <xsl:param name="arg2"/>
   <xsl:param name="arg3"/>   <!-- x -->
   
      
   <xsl:sequence select=
     "f:add(f:apply(f:Prime($arg1),$arg3), 
            f:apply(f:Prime($arg2),$arg3)
            )"/>
 </xsl:template>
 


</xsl:stylesheet>