<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xlink="http://www.w3.org/1999/xlink">

  <xsl:output method="html" encoding="UTF-8" indent="yes"/>

  <xsl:template match="/concessionari">
    <html>
      <head>
        <meta charset="UTF-8"/>
        <title>Informe de Vehicles Elèctrics</title>
        <style>
          body { font-family: sans-serif; margin: 20px; }
          input#filter { padding: 0.5em; width: 200px; margin-bottom: 10px; }
          table { border-collapse: collapse; width: 100%; margin-top: 1em; }
          th, td { border: 1px solid #999; padding: 0.5em; text-align: left; }
          th { background: #eee; }
          .highlight { background-color: #cfc; }
          img { max-width: 100px; height: auto; }
        </style>
        <script>
          function filterTable() {
            var f = document.getElementById('filter').value.toLowerCase();
            document.querySelectorAll('tbody tr').forEach(function(r) {
              r.style.display = 
                r.textContent.toLowerCase().includes(f) ? '' : 'none';
            });
          }
        </script>
      </head>
      <body>
        <h1>Informe de Vehicles Elèctrics</h1>
        <input type="text" id="filter" onkeyup="filterTable()"
               placeholder="Filtra per marca, model…"/>
        <p>
          <strong>Total de vehicles:</strong>
          <xsl:value-of select="count(vehicle[tipus='Elèctric'])"/>
        </p>
        <p>
          <strong>Preu mitjà:</strong> €
          <xsl:value-of select="
            format-number(
              sum(vehicle[tipus='Elèctric']/preu)
                div count(vehicle[tipus='Elèctric']),
            '0.00')"/>
        </p>
        <table>
          <thead>
            <tr>
              <th>Imatge</th><th>Marca</th><th>Model</th>
              <th>Año</th><th>Tipus</th><th>Preu</th>
            </tr>
          </thead>
          <tbody>
            <xsl:for-each select="vehicle[tipus='Elèctric']">
              <!-- Ordenar por año desc -->
              <xsl:sort select="any" order="descending" data-type="number"/>
              <tr>
                <!-- Resaltar autonomía > 400 -->
                <xsl:if test="autonomia &gt; 400">
                  <xsl:attribute name="class">highlight</xsl:attribute>
                </xsl:if>
                <td>
                  <img
                    src="{imagen/@xlink:href}"
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
