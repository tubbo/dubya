require 'spec_helper'

RSpec.describe Dubya do
  context 'when controlling the wiki files' do
    let :command do
      "cd #{Dubya.wiki_path} && bundle exec rake update"
    end

    it 'computes the path to the public dir' do
      expect(Dubya.wiki_path).to match(/public\Z/)
      expect(Dir.exist?(Dubya.wiki_path)).to eq(true)
    end

    it 'builds the command to execute' do
      expect(Dubya.update).to be_a(Mixlib::ShellOut)
      expect(Dubya.update.command).to eq(command)
    end

    it 'updates the wiki from the src dir' do
      allow(Dubya.update).to receive(:run_command).and_return nil
      allow(Dubya.update).to receive(:success?).and_return true

      expect(Dubya).to be_wiki_updated
    end

    it 'returns false when the update command fails' do
      allow(Dubya.update).to receive(:run_command).and_return nil
      allow(Dubya.update).to receive(:success?).and_return false

      expect(Dubya).not_to be_wiki_updated
    end
  end

  context 'the POST route in the API' do
    let :response do
      last_response
    end

    let :json do
      JSON.parse response.body
    end

    it 'updates the wiki when everything is ok' do
      allow(Dubya).to receive(:wiki_updated?).and_return true
      post '/wiki'

      expect(response).to be_ok
      expect(response.status).to eq(200)
      expect(json.keys).to include('notice')
      expect(json['notice']).to eq('The wiki has been updated.')
    end

    it 'renders an http error if something goes wrong' do
      allow(Dubya).to receive(:wiki_updated?).and_return false
      post '/wiki'

      expect(response).not_to be_ok
      expect(response.status).to eq(422)
      expect(json.keys).to include('alert')
      expect(json['alert']).to eq('Error updating wiki.')
    end
  end
end
