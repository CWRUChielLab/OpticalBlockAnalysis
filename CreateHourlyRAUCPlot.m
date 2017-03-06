close all;
clear;

%% Analysis Parameters

sample_index_before_artifact_peak = 60;
sample_index_during_artifact_trough = 120;
sample_index_for_RAUC = sample_index_during_artifact_trough;

%% Analyze Electrical + Laser Experiment

load('data/hl_201605027/AllChartsProcessed.mat');

% Periods of time in seconds during which the laser was off and current was
% fixed. These numbers come from an email from Emilie dated 2017-01-16 with
% the subject line "axograph time points"
hour0 = [   3,     12.5] + sum(DurationsPerChart(1:0));
hour1 = [  27,     37]   + sum(DurationsPerChart(1:1));
hour2 = [   3,     12.5] + sum(DurationsPerChart(1:2));
hour3 = [   3,     13]   + sum(DurationsPerChart(1:3));
hour4 = [  17,     27]   + sum(DurationsPerChart(1:4));
hour5 = [   3.5,   13]   + sum(DurationsPerChart(1:5));
hour6 = [   2.5,   12]   + sum(DurationsPerChart(1:6));
hour7 = [  31.4,   41.2] + sum(DurationsPerChart(1:7));
hour8 = [   8.5,   18.2] + sum(DurationsPerChart(1:8));
hour9 = [3625.7, 3635.7] + sum(DurationsPerChart(1:8)); % these times are not included in the email and were determined by JPG

hour0_trial_idx = find(min(hour0) < TrialTimesAllCharts & TrialTimesAllCharts < max(hour0));
hour1_trial_idx = find(min(hour1) < TrialTimesAllCharts & TrialTimesAllCharts < max(hour1));
hour2_trial_idx = find(min(hour2) < TrialTimesAllCharts & TrialTimesAllCharts < max(hour2));
hour3_trial_idx = find(min(hour3) < TrialTimesAllCharts & TrialTimesAllCharts < max(hour3));
hour4_trial_idx = find(min(hour4) < TrialTimesAllCharts & TrialTimesAllCharts < max(hour4));
hour5_trial_idx = find(min(hour5) < TrialTimesAllCharts & TrialTimesAllCharts < max(hour5));
hour6_trial_idx = find(min(hour6) < TrialTimesAllCharts & TrialTimesAllCharts < max(hour6));
hour7_trial_idx = find(min(hour7) < TrialTimesAllCharts & TrialTimesAllCharts < max(hour7));
hour8_trial_idx = find(min(hour8) < TrialTimesAllCharts & TrialTimesAllCharts < max(hour8));
hour9_trial_idx = find(min(hour9) < TrialTimesAllCharts & TrialTimesAllCharts < max(hour9));

hour0_RAUC = ParaScanAllCharts(hour0_trial_idx, sample_index_for_RAUC);
hour1_RAUC = ParaScanAllCharts(hour1_trial_idx, sample_index_for_RAUC);
hour2_RAUC = ParaScanAllCharts(hour2_trial_idx, sample_index_for_RAUC);
hour3_RAUC = ParaScanAllCharts(hour3_trial_idx, sample_index_for_RAUC);
hour4_RAUC = ParaScanAllCharts(hour4_trial_idx, sample_index_for_RAUC);
hour5_RAUC = ParaScanAllCharts(hour5_trial_idx, sample_index_for_RAUC);
hour6_RAUC = ParaScanAllCharts(hour6_trial_idx, sample_index_for_RAUC);
hour7_RAUC = ParaScanAllCharts(hour7_trial_idx, sample_index_for_RAUC);
hour8_RAUC = ParaScanAllCharts(hour8_trial_idx, sample_index_for_RAUC);
hour9_RAUC = ParaScanAllCharts(hour9_trial_idx, sample_index_for_RAUC);

hour0_RAUC_mean = mean(hour0_RAUC);
hour1_RAUC_mean = mean(hour1_RAUC);
hour2_RAUC_mean = mean(hour2_RAUC);
hour3_RAUC_mean = mean(hour3_RAUC);
hour4_RAUC_mean = mean(hour4_RAUC);
hour5_RAUC_mean = mean(hour5_RAUC);
hour6_RAUC_mean = mean(hour6_RAUC);
hour7_RAUC_mean = mean(hour7_RAUC);
hour8_RAUC_mean = mean(hour8_RAUC);
hour9_RAUC_mean = mean(hour9_RAUC);

hour0_RAUC_se = std(hour0_RAUC)/sqrt(length(hour0_RAUC));
hour1_RAUC_se = std(hour1_RAUC)/sqrt(length(hour1_RAUC));
hour2_RAUC_se = std(hour2_RAUC)/sqrt(length(hour2_RAUC));
hour3_RAUC_se = std(hour3_RAUC)/sqrt(length(hour3_RAUC));
hour4_RAUC_se = std(hour4_RAUC)/sqrt(length(hour4_RAUC));
hour5_RAUC_se = std(hour5_RAUC)/sqrt(length(hour5_RAUC));
hour6_RAUC_se = std(hour6_RAUC)/sqrt(length(hour6_RAUC));
hour7_RAUC_se = std(hour7_RAUC)/sqrt(length(hour7_RAUC));
hour8_RAUC_se = std(hour8_RAUC)/sqrt(length(hour8_RAUC));
hour9_RAUC_se = std(hour9_RAUC)/sqrt(length(hour9_RAUC));

normalization_factor = hour0_RAUC_mean;

ElectricalAndLaserHourlyTimes = [ ...
    mean(hour0) ...
    mean(hour1) ...
    mean(hour2) ...
    mean(hour3) ...
    mean(hour4) ...
    mean(hour5) ...
    mean(hour6) ...
    mean(hour7) ...
    mean(hour8) ...
    mean(hour9) ...
    ] / 3600; % convert from sec to hr

ElectricalAndLaserHourlyRAUCMean = [ ...
    hour0_RAUC_mean ...
    hour1_RAUC_mean ...
    hour2_RAUC_mean ...
    hour3_RAUC_mean ...
    hour4_RAUC_mean ...
    hour5_RAUC_mean ...
    hour6_RAUC_mean ...
    hour7_RAUC_mean ...
    hour8_RAUC_mean ...
    hour9_RAUC_mean ...
    ] / normalization_factor; % normalize by initial RAUC

ElectricalAndLaserHourlyRAUCSE = [ ...
    hour0_RAUC_se ...
    hour1_RAUC_se ...
    hour2_RAUC_se ...
    hour3_RAUC_se ...
    hour4_RAUC_se ...
    hour5_RAUC_se ...
    hour6_RAUC_se ...
    hour7_RAUC_se ...
    hour8_RAUC_se ...
    hour9_RAUC_se ...
    ] / normalization_factor; % normalize by initial RAUC

%% Analyze Electrical Only Experiment

load('data/10.11.2016/AllChartsProcessed.mat');

hour0 = [10 20]; % the first trials begin a few seconds later in this experiment
% hour1 through hour9 will be sampled at precisely the same times as the
% electrical & laser experiment. The timing of hour9 in the electrical only
% experiment was verified to precede the end-of-experiment adjustments made
% to the current, which occur after the last chart was stopped and
% restarted near its end

hour0_trial_idx = find(min(hour0) < TrialTimesAllCharts & TrialTimesAllCharts < max(hour0));
hour1_trial_idx = find(min(hour1) < TrialTimesAllCharts & TrialTimesAllCharts < max(hour1));
hour2_trial_idx = find(min(hour2) < TrialTimesAllCharts & TrialTimesAllCharts < max(hour2));
hour3_trial_idx = find(min(hour3) < TrialTimesAllCharts & TrialTimesAllCharts < max(hour3));
hour4_trial_idx = find(min(hour4) < TrialTimesAllCharts & TrialTimesAllCharts < max(hour4));
hour5_trial_idx = find(min(hour5) < TrialTimesAllCharts & TrialTimesAllCharts < max(hour5));
hour6_trial_idx = find(min(hour6) < TrialTimesAllCharts & TrialTimesAllCharts < max(hour6));
hour7_trial_idx = find(min(hour7) < TrialTimesAllCharts & TrialTimesAllCharts < max(hour7));
hour8_trial_idx = find(min(hour8) < TrialTimesAllCharts & TrialTimesAllCharts < max(hour8));
hour9_trial_idx = find(min(hour9) < TrialTimesAllCharts & TrialTimesAllCharts < max(hour9));

hour0_RAUC = ParaScanAllCharts(hour0_trial_idx, sample_index_for_RAUC);
hour1_RAUC = ParaScanAllCharts(hour1_trial_idx, sample_index_for_RAUC);
hour2_RAUC = ParaScanAllCharts(hour2_trial_idx, sample_index_for_RAUC);
hour3_RAUC = ParaScanAllCharts(hour3_trial_idx, sample_index_for_RAUC);
hour4_RAUC = ParaScanAllCharts(hour4_trial_idx, sample_index_for_RAUC);
hour5_RAUC = ParaScanAllCharts(hour5_trial_idx, sample_index_for_RAUC);
hour6_RAUC = ParaScanAllCharts(hour6_trial_idx, sample_index_for_RAUC);
hour7_RAUC = ParaScanAllCharts(hour7_trial_idx, sample_index_for_RAUC);
hour8_RAUC = ParaScanAllCharts(hour8_trial_idx, sample_index_for_RAUC);
hour9_RAUC = ParaScanAllCharts(hour9_trial_idx, sample_index_for_RAUC);

hour0_RAUC_mean = mean(hour0_RAUC);
hour1_RAUC_mean = mean(hour1_RAUC);
hour2_RAUC_mean = mean(hour2_RAUC);
hour3_RAUC_mean = mean(hour3_RAUC);
hour4_RAUC_mean = mean(hour4_RAUC);
hour5_RAUC_mean = mean(hour5_RAUC);
hour6_RAUC_mean = mean(hour6_RAUC);
hour7_RAUC_mean = mean(hour7_RAUC);
hour8_RAUC_mean = mean(hour8_RAUC);
hour9_RAUC_mean = mean(hour9_RAUC);

hour0_RAUC_se = std(hour0_RAUC)/sqrt(length(hour0_RAUC));
hour1_RAUC_se = std(hour1_RAUC)/sqrt(length(hour1_RAUC));
hour2_RAUC_se = std(hour2_RAUC)/sqrt(length(hour2_RAUC));
hour3_RAUC_se = std(hour3_RAUC)/sqrt(length(hour3_RAUC));
hour4_RAUC_se = std(hour4_RAUC)/sqrt(length(hour4_RAUC));
hour5_RAUC_se = std(hour5_RAUC)/sqrt(length(hour5_RAUC));
hour6_RAUC_se = std(hour6_RAUC)/sqrt(length(hour6_RAUC));
hour7_RAUC_se = std(hour7_RAUC)/sqrt(length(hour7_RAUC));
hour8_RAUC_se = std(hour8_RAUC)/sqrt(length(hour8_RAUC));
hour9_RAUC_se = std(hour9_RAUC)/sqrt(length(hour9_RAUC));

normalization_factor = hour0_RAUC_mean;

ElectricalOnlyHourlyTimes = [ ...
    mean(hour0) ...
    mean(hour1) ...
    mean(hour2) ...
    mean(hour3) ...
    mean(hour4) ...
    mean(hour5) ...
    mean(hour6) ...
    mean(hour7) ...
    mean(hour8) ...
    mean(hour9) ...
    ] / 3600; % convert from sec to hr

ElectricalOnlyHourlyRAUCMean = [ ...
    hour0_RAUC_mean ...
    hour1_RAUC_mean ...
    hour2_RAUC_mean ...
    hour3_RAUC_mean ...
    hour4_RAUC_mean ...
    hour5_RAUC_mean ...
    hour6_RAUC_mean ...
    hour7_RAUC_mean ...
    hour8_RAUC_mean ...
    hour9_RAUC_mean ...
    ] / normalization_factor; % normalize by initial RAUC

ElectricalOnlyHourlyRAUCSE = [ ...
    hour0_RAUC_se ...
    hour1_RAUC_se ...
    hour2_RAUC_se ...
    hour3_RAUC_se ...
    hour4_RAUC_se ...
    hour5_RAUC_se ...
    hour6_RAUC_se ...
    hour7_RAUC_se ...
    hour8_RAUC_se ...
    hour9_RAUC_se ...
    ] / normalization_factor; % normalize by initial RAUC

%% Plot

set(0,'defaultAxesFontSize', 20);
hf1 = figure;
hold on;
ax = gca;
ax.Clipping = 'off';
errorbar( ...
    ElectricalAndLaserHourlyTimes, ...
    ElectricalAndLaserHourlyRAUCMean, ...
    ElectricalAndLaserHourlyRAUCSE, ...
    'color', 'r', ...
    'LineWidth', 2);
errorbar( ...
    ElectricalOnlyHourlyTimes, ...
    ElectricalOnlyHourlyRAUCMean, ...
    ElectricalOnlyHourlyRAUCSE, ...
    'color', 'b', ...
    'LineWidth', 2);
title('Effects of 9 Hours of Stimulation on CAP Energy');
axis([0 max([ElectricalAndLaserHourlyTimes ElectricalOnlyHourlyTimes]) 0 1]);
xlabel('Time (hours)');
ylabel('Normalized rectified area under the curve');
legend( ...
    'Laser applied continually (measurements taken during short breaks)', ...
    'Laser never applied', ...
    'Location', ...
    'southeast' ...
    );
%legend('boxoff');
set(gcf, 'color', 'w');

filename = 'figures/Hourly RAUC with and without laser.png';
set(hf1, 'Units', 'normalized', 'Position', [0,0,1,1]);
hgexport(hf1, filename, hgexport('factorystyle'), 'Format', 'png');
