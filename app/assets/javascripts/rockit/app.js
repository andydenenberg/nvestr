
function ChartFamilyRank(rank){
    var line1 = rank ;
 
    $('#barChart').jqplot([line1], {
        title:'Family Favorite Standings',
        // Provide a custom seriesColors array to override the default colors.
        seriesColors:['#85802b', '#00749F', '#73C774', '#C7754C', '#17BDB8', '#ABCDB8'],
        seriesDefaults:{
            renderer:$.jqplot.BarRenderer,
            rendererOptions: {
                // Set varyBarColor to tru to use the custom colors on the bars.
                varyBarColor: true
            }
        },
        axes:{
            xaxis:{
                renderer: $.jqplot.CategoryAxisRenderer
            }
        }
    });

}



