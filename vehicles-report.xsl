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
            var input = document.getElementById('filter');
            var filter = input.value.toLowerCase();
            var rows = document.querySelectorAll('tbody tr');
            rows.forEach(function(row) {
              var text = row.textContent.toLowerCase();
              row.style.display = text.indexOf(filter) > -1 ? '' : 'none';
            });
          }
        </script>
      </head>
      <body>
        <h1>Informe de Vehicles Elèctrics</h1>

        <!-- Filtro dinámico -->
        <input type="text" id="filter" onkeyup="filterTable()" placeholder="Filtra per marca, model…"/>

        <!-- Totals i preu mitjà -->
        <p><strong>Total de vehicles:</strong>
          <xsl:value-of select="count(vehicle[tipus='Elèctric'])"/>
        </p>
        <p><strong>Preu mitjà:</strong> €
          <xsl:value-of select="format-number(
            sum(vehicle[tipus='Elèctric']/preu)
              div count(vehicle[tipus='Elèctric']),
            '0.00')"/>
        </p>

        <!-- Taula amb columna d'imatge -->
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
            <xsl:for-each select="vehicle[tipus='Elèctric']">
              <xsl:sort select="any" order="descending" data-type="number"/>
              <tr>
                <xsl:if test="autonomia &gt; 400">
                  <xsl:attribute name="class">highlight</xsl:attribute>
                </xsl:if>
                <td>
                  <img>
                    <xsl:attribute name="src">
                      <xsl:value-of select="imagen/@xlink:href"/>
                    </xsl:attribute>
                    <xsl:attribute name="alt">
                      <xsl:value-of select="concat(marca,' ',model)"/>
                    </xsl:attribute>
                  </img>
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