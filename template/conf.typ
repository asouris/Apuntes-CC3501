#let departamentos = (
  adh: (
    nombre: "Área de Humanidades",
    logo: "adh.svg"
  ),
  das: (
    nombre: "Departamento de Astronomía",
    logo: "das.svg"
  ),
  dcc: (
    nombre: "Departamento de Ciencias de la Computación",
    logo: "dcc.svg"
  ),
  dfi: (
    nombre: "Departamento de Física",
    logo: "dfi.svg"
  ),
  dgf: (
    nombre: "Departamento de Geofísica",
    logo: "dgf.svg"
  ),
  dic: (
    nombre: "Departamento de Ingeniería Civil",
    logo: "dic.svg"
  ),
  die: (
    nombre: "Departamento de Ingeniería Eléctrica",
    logo: "die.svg"
  ),
  dii: (
    nombre: "Departamento de Ingeniería Industrial",
    logo: "dii.svg"
  ),
  dim: (
    nombre: "Departamento de Ingeniería Matemática",
    logo: "dim.svg"
  ),
  dimec: (
    nombre: "Departamento de Ingeniería Mecánica",
    logo: "dimec.svg"
  ),
  dimin: (
    nombre: "Departamento de Ingeniería de Minas",
    logo: "dimin.svg"
  ),
  diqbm: (
    nombre: "Departamento de Ingeniería Química, Biotecnología y Materiales",
    logo: "diqbm.svg"
  ),
  geo: (
    nombre: "Deparamento de Geología",
    logo: "geo.svg"
  )
)

#let conf(
  titulo: none,
  subtitulo: none,
  departamento: "dcc",
  profesores: (),
  auxiliares: [],
  curso: "",
  fuente: "New Computer Modern",
  doc,
  autores:[]
) = {
  set text(lang: "es", font: fuente)
  // Formato de headings. Por defecto (P1., P2., etc)
  //set heading(numbering: "P1.") 

  let header = [
    #stack(dir: ltr,
      // El primer elemento del header es el texto, apilado usando un stack.
      align(bottom+left, stack(dir: ttb, spacing: 3pt, "Facultad de Ciencias Físicas y Matemáticas",
          departamentos.at(departamento).nombre,
          curso
      )),
      // Acá va el logo.
      align(bottom+right, box(height: 50pt, image("logos/"+ departamentos.at(departamento).logo)))
    )
    #v(-5pt)
    #line(length: 100%, stroke: 0.4pt)
  ]

  let profesores-title = "Profesor";
  let autores-title = "Autor";
  // Manejar singular o plural dependiendo de la cantidad de profesores/auxiliares
  if profesores.len() > 1 {
    profesores-title = profesores-title + "es"
  }
  if autores.len() > 1 {
    autores-title = autores-title + "es"
  }
  let title = align(center + horizon)[
    #grid(row-gutter: 11pt,
      text(25pt, titulo)
    )
    #v(5pt)
    #align(right + bottom)[#grid(columns: 170pt, row-gutter: 6pt,
      align(left)[*#profesores-title:* #profesores.join(", ", last: " y ")],
      align(left)[*#autores-title:* #autores.join(", ", last: " y ")]
    )]
  ]

  // Configuración del tamaño de página, márgenes y header
  style(styles => { // Usamos la función "style" para acceder a los estilos actuales y medir headerHeight correctamente
    let headerHeight = measure(header, styles).height
    let headerSep = 20pt // Separación entre header y contenido
    set page("us-letter", 
      margin: (left: 1in, 
        right: 1in, 
        top: 0.5in + headerHeight + headerSep, 
        bottom: 1in), 
      header: header, 
      header-ascent: headerSep)
    title
    doc
  })
}
