    h=figure; 
    x = -pi:pi/12:pi;
      y = tan(sin(x)) - sin(tan(x));
      plot(x,y,'-- ro','LineWidth',2,'MarkerEdgeColor','k','MarkerFaceColor','g','MarkerSize',7.5);
     mmzoom ;     
