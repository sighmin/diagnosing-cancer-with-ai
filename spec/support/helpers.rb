# General test helpers

def nn_training_problem_options
  {
    type: :nn_training_problem,
    objective: :minimization,
    dataset: {
      file: 'data/breast_cancer.csv',
      training: 0.64
    },
    neural_network: {
      layers: [{
        size: 30,
        bias: true,
        function: nil
      },{
        size: 7,
        bias: true,
        function: :sigmoid
      },{
        size: 1,
        bias: false,
        function: :sigmoid
      }]
    },
    precision: 0.25
  }
end
