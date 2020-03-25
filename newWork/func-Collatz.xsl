<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:saxon="http://saxon.sf.net/"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="f xs saxon"
 >
  <xsl:output method="text"/>
 <xsl:template match="/">

   <xsl:for-each select="2 to 1000000">
     <xsl:sequence select=
      "if(f:max-collatz-length(current())
         gt
          f:max-collatz-length(current()-1)
          )
          then
            (current(),': ', f:max-collatz-length(current()), '&#xA;')
          else ()
      "
         />
   </xsl:for-each>
 </xsl:template>
 
 <xsl:function name="f:collatz-seq" as="xs:integer+">
   <xsl:param name="pN" as="xs:integer"/>
   
   <xsl:sequence select="$pN"/>

   <xsl:sequence select=
    "if($pN ne 1)
       then 
         for $pNext in
                 (if($pN mod 2 eq 0) 
                    then $pN idiv 2
                    else 3*$pN + 1
                  )
               return f:collatz-seq($pNext)
        else ()
    "
    />
 </xsl:function>

 <xsl:function name="f:max-collatz-length" as="xs:integer"
               saxon:memo-function="yes" >
   <xsl:param name="pN" as="xs:integer"/>
   
   <xsl:sequence select=
    "if($pN eq 1)
       then 1
       else max((f:max-collatz-length($pN - 1), f:collatz-length($pN)))
    "
    />
 </xsl:function>
 
 <xsl:function name="f:collatz-length" as="xs:integer" 
               saxon:memo-function="yes" >
   <xsl:param name="pN" as="xs:integer"/>
   
   <xsl:sequence select=
    "if($pN eq 1)
        then 1
        else 
         for $pNext in
                 (if($pN mod 2 eq 0) 
                    then $pN idiv 2
                    else 3*$pN + 1
                  )
               return 1 + f:collatz-length($pNext)
    "
    />
 </xsl:function>
</xsl:stylesheet>