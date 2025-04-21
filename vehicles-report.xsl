<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xlink="http://www.w3.org/1999/xlink">

  <!-- Salida como HTML -->
  <xsl:output method="html" encoding="UTF-8" indent="yes"/>

  <!-- Plantilla principal: arranca en la raíz <concessionari> -->
  <xsl:template match="/concessionari">
    <html>
      <head>
        <meta charset="UTF-8"/>
        <title>Informe de Vehicles Elèctrics</title>
        <style>
          body { font-family: sans-serif; margin:20px; }
          table { border-collapse: collapse; width:100%; margin-top:1em; }
          th, td { border:1px solid #999; padding:0.5em; text-align:left; }
          th { background:#eee; }
          .highlight { background:#cfc; }
          img { max-width:100px; height:auto; }
        </style>
      </head>
      <body>
        <h1>Informe de Vehicles Elèctrics</h1>

        <!-- Totals -->
        <p><strong>Total de vehicles:</strong>
          <xsl:value-of select="count(vehicle[tipus='Elèctric'])"/>
        </p>
        <p><strong>Preu mitjà:</strong> €
          <xsl:value-of select="format-number(
            sum(vehicle[tipus='Elèctric']/preu)
              div count(vehicle[tipus='Elèctric']),
            '0.00')"/>
        </p>

        <!-- Tabla -->
        <table>
          <thead>
            <tr>
              <th>Imatge</th>
              <th>Marca</th>
              <th>Model</th>
              <th>Año</th>
              <th>Tipus</th>
              <th>Preu</th>
            </tr>
          </thead>
          <tbody>
            <!-- Solo eléctricos, ordenados por año descendente -->
            <xsl:for-each select="vehicle[tipus='Elèctric']">
              <xsl:sort select="any" order="descending" data-type="number"/>
              <tr>
                <!-- Destacar autonomía > 400 -->
                <xsl:if test="autonomia &gt; 400">
                  <xsl:attribute name="class">highlight</xsl:attribute>
                </xsl:if>
                <td>
                  <img src="{imagen/@xlink:href}"
                       alt="{concat(marca,' ',model)}"/>
                </td>
                <td><xsl:value-of select="marca"/></td>
                <td><xsl:value-of select="model"/></td>
                <td><xsl:value-of select="any"/></td>
                <td><xsl:value-of select="tipus"/></td>
                <td>€<xsl:value-of select="preu"/></td>
              </tr>
            </xsl:for-each>
          </tbody>
        </table>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>

        
