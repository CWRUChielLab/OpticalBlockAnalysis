clear;
addpath(genpath('include'));


%% GLOBAL SETTINGS

save_intermediate_chart_results  = true;
skip_charts_previously_processed = true;


%% EXPERIMENT SETTINGS

Experiments = { ...
    
    % ELECTRICAL & LASER EXPERIMENT (9 HOURS TOTAL)
    struct( ...
        'title', 'hl_201605027 (9 Hours With Laser)', ...
        'charts', {{ ...
            'data/hl_201605027/hl_201605027 002.axgd' ...
            'data/hl_201605027/hl_201605027 003.axgd' ...
            'data/hl_201605027/hl_201605027 004.axgd' ...
            'data/hl_201605027/hl_201605027 005.axgd' ...
            'data/hl_201605027/hl_201605027 006.axgd' ...
            'data/hl_201605027/hl_201605027 007.axgd' ...
            'data/hl_201605027/hl_201605027 008.axgd' ...
            'data/hl_201605027/hl_201605027 009.axgd' ...
            'data/hl_201605027/hl_201605027 010.axgd' ...
            }}, ...
        'combined_results_filename', ...
            'data/hl_201605027/AllChartsProcessed.mat', ...
        'channel_to_process',        'dist (V)', ...
        'channel_with_stim_trigger', 'dist (V)' ...
        ) ...
    
    % ELECTRICAL ONLY EXPERIMENT (9 HOURS TOTAL)
    struct( ...
        'title', '10.11.2016 (9 Hours Without Laser)', ...
        'charts', {{ ...
            'data/10.11.2016/10.11.2016 005.axgd' ...
            'data/10.11.2016/10.11.2016 006.axgd' ...
            'data/10.11.2016/10.11.2016 007.axgd' ...
            'data/10.11.2016/10.11.2016 008.axgd' ...
            'data/10.11.2016/10.11.2016 009.axgd' ...
            }}, ...
        'combined_results_filename', ...
            'data/10.11.2016/AllChartsProcessed.mat', ...
        'channel_to_process',        'dist (V)', ...
        'channel_with_stim_trigger', 'dist (V)' ...
        ) ...
    
    % ELECTRICAL & LASER EXPERIMENT (8 HOURS TOTAL)
    struct( ...
        'title', 'hl_201605031 (8 Hours With Laser)', ...
        'charts', {{ ...
            'data/hl_201605031/hl_201605031 002.axgd' ...
            'data/hl_201605031/hl_201605031 003.axgd' ...
            'data/hl_201605031/hl_201605031 004 Partial Data Recovery.axgx' ...
            'data/hl_201605031/hl_201605031 005 Partial Data Recovery.axgx' ...
            'data/hl_201605031/hl_201605031 006 Partial Data Recovery.axgx' ...
            'data/hl_201605031/hl_201605031 007.axgx' ...
            'data/hl_201605031/hl_201605031 008.axgd' ...
            'data/hl_201605031/hl_201605031 009.axgd' ...
            }}, ...
        'combined_results_filename', ...
            'data/hl_201605031/AllChartsProcessed.mat', ...
        'channel_to_process',        'dist (V)', ...
        'channel_with_stim_trigger', 'dist (V)' ...
        ) ...
    
    % ELECTRICAL & LASER EXPERIMENT (7 HOURS TOTAL)
    struct( ...
        'title', 'hl_201605017 (7 Hours With Laser)', ...
        'charts', {{ ...
            'data/hl_201605017/hl_201605017 002.axgd' ...
            'data/hl_201605017/hl_201605017 003.axgd' ...
            'data/hl_201605017/hl_201605017 004.axgd' ...
            'data/hl_201605017/hl_201605017 005.axgd' ...
            'data/hl_201605017/hl_201605017 006.axgd' ...
            'data/hl_201605017/hl_201605017 007.axgd' ...
            'data/hl_201605017/hl_201605017 008.axgd' ...
            }}, ...
        'combined_results_filename', ...
            'data/hl_201605017/AllChartsProcessed.mat', ...
        'channel_to_process',        'dist (V)', ...
        'channel_with_stim_trigger', 'dist (V)' ...
        ) ...
    
    };


%% PROCESS DATA

tic_all = tic; % start a timer for the entire script

for i = 1:length(Experiments)
    
    ex = Experiments{i};
    
    fprintf('Starting experiment "%s" ...\n\n', ex.title);
    tic_experiment = tic; % start a timer for this experiment

    % Initialize arrays to hold data from all charts
    TrialsPerChart               = [];
    TrialTimesAllCharts          = [];
    DurationsPerChart            = [];
    CAPsignalAllCharts           = [];
    ParaScanAllCharts            = [];
    ParaScan2AllCharts           = [];
    ArtifactHeightsAllCharts     = [];
    ArtifactTimesAllCharts       = [];
    ArtifactWidthsAllCharts      = [];
    ArtifactProminencesAllCharts = [];
    CAP1HeightsAllCharts         = [];
    CAP1TimesAllCharts           = [];
    CAP1WidthsAllCharts          = [];
    CAP1ProminencesAllCharts     = [];

    % Process charts one at a time
    for j = 1:length(ex.charts)

        % Determine input file name
        input_filename = ex.charts{j};
        fprintf('Processing chart %d of %d ...\n', j, length(ex.charts));
        tic_chart = tic; % start a timer for this chart

        % Determine output file name
        [pathstr, name, ext] = fileparts(input_filename);
        output_filename = fullfile(pathstr, strcat(name, ' - Processed.mat'));

        % Process chart and save results to file if output file does not
        % already exist, otherwise load output file
        if ~skip_charts_previously_processed || ~exist(output_filename, 'file')

            result = ProcessChart(input_filename, ex.channel_to_process, ex.channel_with_stim_trigger);
            if save_intermediate_chart_results
                fprintf('saving results ...\n');
                save(output_filename, 'result');
            end

        else

            fprintf('loading pre-processed data ... (you may delete ''%s'' to re-process)\n', output_filename);
            load(output_filename);

        end

        fprintf('combining results with other charts ...\n');
        TrialsPerChart               = [TrialsPerChart;               result.n_trials];
        TrialTimesAllCharts          = [TrialTimesAllCharts;          sum(DurationsPerChart)+result.stim_times];
        DurationsPerChart            = [DurationsPerChart;            result.duration];
        CAPsignalAllCharts           = [CAPsignalAllCharts;           result.CAPsignal];
        ParaScanAllCharts            = [ParaScanAllCharts;            result.ParaScan];
        ParaScan2AllCharts           = [ParaScan2AllCharts;           result.ParaScan2];
        ArtifactHeightsAllCharts     = [ArtifactHeightsAllCharts;     result.artifact_heights];
        ArtifactTimesAllCharts       = [ArtifactTimesAllCharts;       result.artifact_times];
        ArtifactWidthsAllCharts      = [ArtifactWidthsAllCharts;      result.artifact_widths];
        ArtifactProminencesAllCharts = [ArtifactProminencesAllCharts; result.artifact_prominences];
        CAP1HeightsAllCharts         = [CAP1HeightsAllCharts;         result.CAP1_heights];
        CAP1TimesAllCharts           = [CAP1TimesAllCharts;           result.CAP1_times];
        CAP1WidthsAllCharts          = [CAP1WidthsAllCharts;          result.CAP1_widths];
        CAP1ProminencesAllCharts     = [CAP1ProminencesAllCharts;     result.CAP1_prominences];

        toc(tic_chart); % print time spent on this chart
        fprintf('\n');
        
    end  % for each chart


    %% SAVE COMBINED RESULTS

    fprintf('Saving combined chart results for this experiment ...\n');
    ArtifactLength = result.artifact_length;  % assuming this is the same for all charts
    ArtifactNPeaks = result.n_artifact_peaks; % assuming this is the same for all charts
    CAP1Threshold = result.CAP1_threshold;    % assuming this is the same for all charts
    CAP1Window = result.CAP1_window;          % assuming this is the same for all charts
    SampleFreq = result.sample_freq;          % assuming this is the same for all charts
    SampleTimes = result.sample_times;        % assuming this is the same for all charts
    StimFreq = result.stim_freq;              % assuming this is the same for all charts
    save(ex.combined_results_filename, ...
        'ArtifactHeightsAllCharts', ...
        'ArtifactLength', ...
        'ArtifactNPeaks', ...
        'ArtifactProminencesAllCharts', ...
        'ArtifactTimesAllCharts', ...
        'ArtifactWidthsAllCharts', ...
        'CAPsignalAllCharts', ...
        'CAP1HeightsAllCharts', ...
        'CAP1ProminencesAllCharts', ...
        'CAP1Threshold', ...
        'CAP1TimesAllCharts', ...
        'CAP1WidthsAllCharts', ...
        'CAP1Window', ...
        'DurationsPerChart', ...
        'ParaScanAllCharts', ...
        'ParaScan2AllCharts', ...
        'SampleFreq', ...
        'SampleTimes', ...
        'StimFreq', ...
        'TrialsPerChart', ...
        'TrialTimesAllCharts' ...
        );
    
    toc(tic_experiment); % print time spent on this experiment
    fprintf('\n');
    
end  % for Experiments

fprintf('All processing complete.\n');
toc(tic_all); % print total elasped time
