<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="f xs"
 >
 
  <xsl:import href="../f/func-dvc-foldl.xsl"/>

  <xsl:function name="f:memAdd" as="element()">
    <f:memAdd/>
  </xsl:function>
  
  <xsl:template match="f:memAdd" mode="f:FXSL"
                as="item()*">
   <xsl:param name="arg1" as="item()*"/>
   <xsl:param name="arg2" as="item()"/>
   
   <xsl:sequence select="f:memAdd($arg1,$arg2)"/>
  </xsl:template>
  
  <xsl:function name="f:memNew" as="item()*">
    <xsl:sequence select="0"/>
  </xsl:function>
  
  <xsl:function name="f:memNew" as="item()*">
    <xsl:param name="pList"/>
    
    <xsl:sequence select=
    "f:foldl(f:memAdd(),f:memNew(), $pList)"/>
  </xsl:function>
  
  <xsl:function name="f:memAdd" as="item()*">
   <xsl:param name="pMem" as="item()*"/>
   <xsl:param name="pItem" as="item()"/>
   
   <xsl:sequence select=
   "xs:integer($pMem[1])+1, subsequence($pMem,2), $pItem"/>
 </xsl:function>
 
 <xsl:function name="f:memGet" as="item()">
   <xsl:param name="pMem" as="item()*"/>
   <xsl:param name="pInd" as="xs:integer"/>
  
   <xsl:sequence select="$pMem[$pInd + 1]"/>
 </xsl:function>

 <xsl:function name="f:memGetSeq" as="item()*">
   <xsl:param name="pMem" as="item()*"/>
   <xsl:param name="pInd1" as="xs:integer"/>
   <xsl:param name="pInd2" as="xs:integer"/>
  
   <xsl:sequence select=
   "subsequence($pMem,$pInd1+1, $pInd2 - $pInd1 + 1)"/>
 </xsl:function>
 
 <xsl:function name="f:subMem" as="item()*">
   <xsl:param name="pMem" as="item()*"/>
   <xsl:param name="pInd" as="xs:integer"/>
  
   <xsl:sequence select=
   "subsequence($pMem, $pInd+1, $pMem[$pInd+1] +1)"/>
 </xsl:function>

 <xsl:function name="f:memRemove" as="item()*">
   <xsl:param name="pMem" as="item()*"/>
   <xsl:param name="pInd" as="xs:integer"/>
   
   <xsl:variable name="vcurLen" as="xs:integer"
    select="$pMem[1]"/>
  
   <xsl:variable name="vRemoved" as="xs:boolean"
   select="$pInd gt 0 and $pInd le $vcurLen"
   />
   
   <xsl:sequence select=
    "if(not($vRemoved))
       then $pMem
       else 
       ($vcurLen -1,
        subsequence($pMem,2,$pInd -1),
        subsequence($pMem,$pInd+2)
        )
       
    "
   />
 </xsl:function>

 <xsl:function name="f:memRemoveSeq" as="item()*">
   <xsl:param name="pMem" as="item()*"/>
   <xsl:param name="pInd" as="xs:integer"/>
   <xsl:param name="pLen" as="xs:integer"/>
   
   <xsl:variable name="vcurLen" as="xs:integer"
    select="$pMem[1]"/>
  
   <xsl:variable name="vRemoved" as="xs:boolean"
   select="$pInd gt 0 and $pInd le $vcurLen"
   />
   
   <xsl:sequence select=
    "if(not($vRemoved))
       then $pMem
       else 
       ($vcurLen - min(($vcurLen, $pLen)),
        subsequence($pMem,2,$pInd -1),
        subsequence($pMem,$pInd+$pLen+1)
        )
       
    "
   />
 </xsl:function>
</xsl:stylesheet>