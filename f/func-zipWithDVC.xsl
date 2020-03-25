<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="f"
>
 <xsl:import href="func-apply.xsl"/>

 <xsl:function name="f:zipWith" as="item()*">
   <xsl:param name="pFun" as="element()"/>
   <xsl:param name="pList1" as="item()*"/>
   <xsl:param name="pList2" as="item()*"/>

   <xsl:sequence select=
    "if(exists($pList1) and exists($pList2))
      then for $vLength in count($pList1) return
             if($vLength > 1)
               then
                 for $vHalf in $vLength idiv 2 return
                   (f:zipWith($pFun,
                              $pList1[position() le $vHalf],
                              $pList2[position() le $vHalf]
                              )
                    ,
                    f:zipWith($pFun,
                              $pList1[position() gt $vHalf],
                              $pList2[position() gt $vHalf]
                              )
                    )
               else
                 f:apply($pFun, $pList1[1], $pList2[1])
      else ()"
   />
 </xsl:function>
</xsl:stylesheet>