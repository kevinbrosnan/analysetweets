dashboardPage(title = app.name,
              skin = (skin.colour),
              dashboardHeader(title = app.name,
                              
                              # Email Sharing link
                              tags$li(class = "dropdown",
                                      tags$a(href = paste0("mailto:?Subject=", app.name, "&Body=", app.share.desc, " ", app.url),
                                             tags$img(height = "18px", 
                                                      src = "images/email.png")
                                      )
                              ),
                              
                              # Twitter Sharing Link
                              tags$li(class = "dropdown",
                                      tags$a(href = paste0("http://twitter.com/share?url=", app.url, "&text=", app.share.desc), 
                                             target = "_blank_", 
                                             tags$img(height = "18px", 
                                                      src = "images/twitter.png")
                                      )
                              ),
                              
                              # Facebook Sharing link
                              tags$li(class = "dropdown",
                                      tags$a(href = paste0("http://www.facebook.com/sharer.php?u=", app.url),
                                             target = "_blank_", 
                                             tags$img(height = "18px", 
                                                      src = "images/facebook.png")
                                      )
                              ),
                              
                              # LinkedIn Sharing link
                              tags$li(class = "dropdown",
                                      tags$a(href = paste0("http://www.linkedin.com/shareArticle?mini=true&url=", app.url), 
                                             target = "_blank_", 
                                             tags$img(height = "18px", 
                                                      src = "images/linkedin.png")
                                      )
                              )
              ),
              
              dashboardSidebar(
                sidebarMenu(
                  menuItem("Analyse Tweets", tabName = "analysis", icon = icon("binoculars")),
                  menuItem("About", tabName = "about", icon = icon("info")),
                  hr(),
                  sidebarUserPanel(name = a(users$user.names[1], 
                                            target = "_blank_",
                                            href = users$user.web[1]), 
                                   subtitle = users$user.job[1],
                                   image = users$user.pic[1]),
                  sidebarUserPanel(name = a(users$user.names[2], 
                                            target = "_blank_",
                                            href = users$user.web[2]), 
                                   subtitle = users$user.job[2],
                                   image = users$user.pic[2])
                  ,
                  hr(),
                  menuItem("Source code", icon = icon("file-code-o"),
                           href = github.repo),
                  menuItem("Bug Reports", icon = icon("bug"),
                           href = github.issues)
                )
              ),
              
              dashboardBody(
                tags$head(includeScript("www/js/google-analytics.js"),
                          HTML('<link rel="apple-touch-icon" sizes="57x57" href="icons/apple-icon-57x57.png">
                                <link rel="apple-touch-icon" sizes="60x60" href="icons/apple-icon-60x60.png">
                                <link rel="apple-touch-icon" sizes="72x72" href="icons/apple-icon-72x72.png">
                                <link rel="apple-touch-icon" sizes="76x76" href="icons/apple-icon-76x76.png">
                                <link rel="apple-touch-icon" sizes="114x114" href="icons/apple-icon-114x114.png">
                                <link rel="apple-touch-icon" sizes="120x120" href="icons/apple-icon-120x120.png">
                                <link rel="apple-touch-icon" sizes="144x144" href="icons/apple-icon-144x144.png">
                                <link rel="apple-touch-icon" sizes="152x152" href="icons/apple-icon-152x152.png">
                                <link rel="apple-touch-icon" sizes="180x180" href="icons/apple-icon-180x180.png">
                                <link rel="icon" type="image/png" sizes="192x192"  href="icons/android-icon-192x192.png">
                                <link rel="icon" type="image/png" sizes="32x32" href="icons/favicon-32x32.png">
                                <link rel="icon" type="image/png" sizes="96x96" href="icons/favicon-96x96.png">
                                <link rel="icon" type="image/png" sizes="16x16" href="icons/favicon-16x16.png">
                                <link rel="manifest" href="icons/manifest.json">
                                <meta name="msapplication-TileColor" content="#ffffff">
                                <meta name="msapplication-TileImage" content="icons/ms-icon-144x144.png">
                                <meta name="theme-color" content="#ffffff">')),
                tabItems(
                  # Analysis Tab
                  tabItem(tabName = "analysis",
                          style = "overflow-y:scroll;",
                          box(width = 6,
                              HTML("<center><h3>Twitter Analysis</h3></center>"),
                              textInput("hashtag", 
                                        "Analyse a #tag or @person:", 
                                        "#limerickandproud"),
                              HTML("<center>"), 
                              submitButton(text = "Start Analysis?"), 
                              HTML("</center>"),
                              br(),
                              HTML("<center><p>"),
                              downloadButton('downloadData', 'Tweets?'),
                              downloadButton('report', 'Report?'),
                              HTML("</p></center>")
                          ),
                          box(width = 6, 
                              plotOutput("timeseries")
                          ),
                          box(width = 6,
                              plotOutput("wordcloud")
                          ),
                          box(width = 6,
                              plotOutput("sentimentanalysis")
                          )
                  ),
                  
                  # About Tab
                  tabItem("about", includeMarkdown("about.md"))
                )
              )
)