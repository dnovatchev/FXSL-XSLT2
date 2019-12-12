<xsl:stylesheet version="2.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:foldl-func="foldl-func"
xmlns:f="http://fxsl.sf.net/"
exclude-result-prefixes="f foldl-func"
>

   <xsl:import href="../f/func-foldl.xsl"/>
   
   <xsl:output omit-xml-declaration="yes" indent="yes"/>

<!--
    This transformation must be applied to:  
        ../data/periods.xml                  
-->
   <xsl:variable name="vFoldlFun" as="element()">
	   <foldl-func:foldl-func/>
   </xsl:variable>
   
   <xsl:variable name="vA0" as="element()+">
     <period start="0" end="0"/>
   </xsl:variable>

    <xsl:template match="/">
      <xsl:sequence select="f:foldl($vFoldlFun, $vA0, /*/* )[position() > 1]"/>
    </xsl:template>
    
    <xsl:template match="foldl-func:*" as="element()+"
     mode="f:FXSL">
       <xsl:param name="arg1"/>
       <xsl:param name="arg2"/>
       
       <xsl:variable name="vLastPeriod" select="$arg1[last()]"/>
         
       <xsl:choose>
         <xsl:when test=
            "number($arg2/@period_begin) > number($vLastPeriod/@end)">
           <xsl:sequence select="$arg1"/>
           <period start="{$arg2/@period_begin}" end="{$arg2/@period_end}"/>
         </xsl:when>
         <xsl:otherwise>
           <xsl:sequence select="$arg1[not(. is $vLastPeriod)]"/>
           <xsl:choose>
             <xsl:when test="number($arg2/@period_end) > number($vLastPeriod/@end)">
               <period start="{$vLastPeriod/@start}" end="{$arg2/@period_end}"/>
             </xsl:when>
             <xsl:otherwise>
               <xsl:sequence select="$vLastPeriod"/>
             </xsl:otherwise>
           </xsl:choose>
         </xsl:otherwise>
       </xsl:choose>
    </xsl:template>

</xsl:stylesheet>