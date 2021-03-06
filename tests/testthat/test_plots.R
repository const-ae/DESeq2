context("plots")
test_that("plots work", {
  # test plots
  dds <- makeExampleDESeqDataSet(n=100,m=8)
  dds$group <- factor(rep(c(1,2,1,2),each=2))
  dds <- DESeq(dds)
  res <- results(dds)
  plotDispEsts(dds)
  plotDispEsts(dds, CV=TRUE)
  plotMA(dds)
  plotMA(dds, ylim=c(-1,1))
  plotCounts(dds, 1)
  plotCounts(dds, 1, intgroup=c("condition","group"))
  plotCounts(dds, 1, transform=TRUE)
  expect_error(plotCounts(dds, 1, intgroup="foo"))
  vsd <- varianceStabilizingTransformation(dds, blind=FALSE)
  plotPCA(vsd)
  dat <- plotPCA(vsd, returnData=TRUE)
  plotPCA(vsd, intgroup=c("condition","group"))
  expect_error(plotPCA(vsd, intgroup="foo"))
  plotSparsity(dds)

  # plotMA MLE
  dds <- DESeq(dds, betaPrior=TRUE)
  res <- results(dds)
  expect_error(plotMA(res, MLE=TRUE))
  res <- results(dds, addMLE=TRUE)
  plotMA(res, MLE=TRUE)

  # plotCounts with numeric variable in design gives error
  dds <- removeResults(dds)
  dds$x <- 1:8  
  design(dds) <- ~x
  dds <- DESeq(dds)
  expect_error(plotCounts(dds, 1, "x"), "plot manually")
  
  dev.off()
  
})
